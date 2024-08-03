#!/bin/sh
gh api graphql -f query='
    {
      viewer {
        contributionsCollection {
            contributionCalendar {
                weeks {
                    contributionDays {
                        contributionCount
                        date
                    }
                }
            }
        }
      }
    }
    '
