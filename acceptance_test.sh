#!/bin/bash
test $(curl "http://localhost:8765/sum?a=10&b=3") -eq 13