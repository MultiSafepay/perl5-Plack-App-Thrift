#!/bin/bash

thrift -r --out . --gen json .thrift
thrift -r --out lib --gen perl .thrift
