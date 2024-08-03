#!/bin/sh
starting_year=2018
current_year=`date +"%Y"`
jq_filter="[
    .data.viewer.contributionsCollection.contributionCalendar.weeks[].contributionDays[]
    | {date:.date, contribution_count:.contributionCount}
    | {date, contribution_count}
]"

getGraphQLQuery() {
    local year=$1
    echo "
    {
      viewer {
        contributionsCollection(from:\"${year}-01-01T00:00:00Z\", to:\"${year}-12-31T23:59:59Z\") {
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
    "
}

for year in $(seq ${starting_year} $current_year)
do
    gh api graphql -f query="`getGraphQLQuery $year`" | jq "$jq_filter"
done
