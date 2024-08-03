#!/bin/sh
jq_filter="[
    .data.viewer.contributionsCollection.contributionCalendar.weeks[].contributionDays[]
    | {date:.date, contribution_count:.contributionCount}
    | {date, contribution_count}
]"

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
    ' | jq "$jq_filter"
