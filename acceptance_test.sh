#!/bin/bash
response=$(curl -s "http://localhost:8765/sum?a=10&b=3")
echo "Server response: $response"

if [ "$response" -eq 13 ]; then
  echo "Test passed"
else
  echo "Test failed"
  exit 1
fi
