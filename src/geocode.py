#!/usr/bin/env python

import requests
import sys
import time
import os

requests.packages.urllib3.disable_warnings()

def geocode(address):
    url = 'https://maps.googleapis.com/maps/api/geocode/json'
    params = {'sensor': 'false', 'address': address, 'key': os.environ['GOOGLE_MAPS_SECRET']}
    r = requests.get(url, params=params)
    results = r.json()['results']
    location = results[0]['geometry']['location']
    return location['lat'], location['lng']

def try_geocode(address):
    n = 10
    sleep = 3
    i = 0
    while i < n:
        try:
            latlong = geocode(address)
            break
        except Exception as e:
            print e
	    print "attempt: {}\n".format(i)
            time.sleep(sleep)
	i += 1
    if i==n:
        raise ValueError("tried {} times and failed".format(n))
    return latlong
 

def lines(fname):
    with open(fname, "r") as f:
        lines = f.readlines()
        lines = [line.rstrip() for line in lines]
        n = len(lines)
    return n, lines

def geocode_from_file(infname, outfname):
    nin, inflines = lines(infname)
    nout, outflines = lines(outfname)

    start = nout
    i = start
    end = nin

    print "starting at line {}\n".format(i)

    with open(outfname, "a") as g:
        while i < end:
            address =  inflines[i]
            latlong = try_geocode(address)
            lat = latlong[0]
            lng = latlong[1]
            line = "\"{}\", {}, {}, {}\n".format(address, lat, lng, i)
            print line
            g.write(line)
            g.flush()
            i += 1 

if __name__=="__main__":
    if len(sys.argv) != 3:
        print "n args must be 2"

    infname = sys.argv[1]
    outfname = sys.argv[2]
    geocode_from_file(infname, outfname)
