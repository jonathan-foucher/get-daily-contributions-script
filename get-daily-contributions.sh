#!/bin/sh
results=[]
jq_filter="[
    .data.viewer.contributionsCollection.contributionCalendar.weeks[].contributionDays[]
    | {date:.date, contribution_count:.contributionCount}
    | {date, contribution_count}
]"

getUserCreatedDate() {
    gh api graphql -f query="
    {
      viewer {
        createdAt
      }
    }
    " \
    | jq -r .data.viewer.createdAt \
    | grep -Eo '^\d{4}-\d{2}-\d{2}' | grep -Eo '^\d{4}'
}

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

starting_year=$(getUserCreatedDate)
current_year=`date +"%Y"`
for year in $(seq ${starting_year} $current_year)
do
    year_result=$(gh api graphql -f query="`getGraphQLQuery $year`" | jq "$jq_filter")
    results=`echo "[$results, $year_result]" | jq ". | flatten"`
done

echo $results
