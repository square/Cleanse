#!/bin/bash

bundle install || bundle update || true
bundle exec fastlane lint || true
