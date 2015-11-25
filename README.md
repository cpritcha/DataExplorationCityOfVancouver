# Canada Line Development

The development of the area around Canada Line is explored by looking at the number of business licences issued at different areas along the track over time.

## Software Used

- `R 3.2.2` (with the checkpoint library)
- `QGIS 2.12.0-Lyon` (with the NNJoin and Table Manager plugins installed)
- `Python 2.7` (with the virtualenv package)

## Other Requirements

- Google Maps API secret key in the environmental variable `GOOGLE_MAPS_SECRET`

## Setup

### R Setup

Install the `checkpoint` package and run `src/requires.R`.

### Python Setup

```bash
# start in the src/ directory
virtualenv .proj
. .proj/bin/activate
pip install -r requirements.txt
```

## Reproduce the Graphs

1. Open as an RStudio project and run `requires.R`
  (this will take a while)
2. Run `s1_business_data_download.R`
3. Run `s2_transit_selection.R`
4. Run

  ```
  # start in the data directory
  touch geocoded_02_08_14.txt
  ./geocode.py addresses.txt geocoded_02_08_14.txt
  ```

  (with the `virtualenv` activated). The output file `geocoded_02_08_14.txt` is imported in the next step.
5. Run `s3_import_geocoded.R`
6. Perform instructions from the *Prepare the Spatial data* section
7. Run `s4_combine_geocoded_with_rest_of_data.R`

Run `s5_graphics.Rmd` for the report graphics, `s5_table.R` for the table
statistics and `s5_graphics.R` for the presentation graphics

## Prepare the Spatial data

Additional datasets required:

- [Local Area Boundary](http://data.vancouver.ca/download/kml/cov_localareas.kml)
- [Rapid Transit Lines](http://data.vancouver.ca/download/kml/shape_rapid_transit.zip)
- [Rapid Transit Stations](ftp://webftp.vancouver.ca/OpenData/shape/shape_rapid_transit.zip)

### Prepare Rapid Transit Lines

1. Import the Rapid Transit Line `RTL` file into QGIS.
2. Select Canada Line from the `RTL` layer
3. Reproject the dataset into UTM Z10N (EPSG 32610) using the selected feature and save it disk (I'll call it `CanLine`)

### Prepare Rapid Transit Stations

1. Import the Rapid Transit Stations `RTS` file into QGIS.
2. Select all Canada Line stations from the `RTS` layer
3. Reproject the dataset into UTM Z10N (EPSG 32610) using the selected feature and save it disk (I'll call it `CanStations`)

### Prepare Local Area Boundary

1. Import the Local Area Boundary `RTS` file into QGIS.
2. Reproject the dataset into UTM Z10N (EPSG 32610) using the selected feature and save it disk (I'll call it `LocalArea`)

### Prepare the Geocoded Data

1. Import the `data/stage3.csv` file into QGIS (should have been produced after running `s3_import_geocoded.R`)
2. Reproject the dataset into UTM Z10N (EPSG 32610) using the selected feature and save it disk (I'll call it `Stage3`)

### Buffer `CanLine`

1. Create a 1km buffer around Canada Line using Geoprocessing Tools
2. Save it and call it `CanLineBuffer`

### Select the Geocoded Data

Select business licences from `Stage3` that interesect `CanLineBuffer` and call it `Stage3InBuffer`

### Calculate the Distance to Station and Tracks (Requires the NNJoin and Table Manager plugins)

1. Use NNJoin (input layer: `Stage3InBuffer` and join layer `CanLine`). Use Table Manager to delete all columns beginning with "join_", rename the "distance" column to "d_to_track" and call the output `Part2Stage3InBuffer`
2. Use NNJoin (input layer: `Part2Stage3InBuffer` and join layer `CanStaions`). Use Table Manager to delete all columns beginning with "join_", rename the "distance" column to "d_to_stat" and call the output `Part3Stage3InBuffer`
3. Export `Part3Stage3InBuffer` as a csv file (call it `dist.csv` and place it in the `data` directory for use in step 7 of the reproduce the graphs section)

## Create Maps

1. Import `data/complete.txt` into QGIS and reproject it UTM Z10N (call it `BusinessLicences`)
2. Add styles to `BusinessLicences`, `CanLineBuffer`, `CanStations` and `CanLine` to match the
  final maps shown in the `graphics` directory.
3. Use QGIS print composer to add the scale bars and projection information export the results
  filtering the `BusinessLicenses` layer to the year 2002 and 2014 respectively.
