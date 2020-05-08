# StravaClubActivities

This tool downloads the club activities using the strava API and generates a CSV file for processing virtual race events.

## Usage
Running it locally can be done like this:
```
bundle exec ruby bin/club_activities -h

----------------------------------
      Strava Club Activities
----------------------------------
This app is designed to pull back data from Strava's API and dump it in a CSV.
There are two modes: 'segment' and 'club'

Club mode: Pull down all the activities done by athletes in the club for that day.
           Filter parameter will be searching the run title.
           WARNING: This is based on who you follow. If others have set their profile to private and you
                    do not have them added then they will not appear!

Segment mode: Pull down the best activity performed by club athletes for that day in the segment specified.
              You MUST have this segment starred otherwise segment will not be found.
              Filter parameter will be searching for the segment name.

Usage examples:
       club_activities --mode segment --access-token <token> --filter <segment_name>
       club_activities --mode club --access-token <token> --filter <run_title>

Options:
  -m, --mode=<s>            Values: segment/club, Process either club activities or the segment activities
  -a, --access-token=<s>    Strava access token
  -f, --filter=<s>          Description to filter by (case-insensitive). Filters run name in club mode. Filters Segment name in segment mode.
                            (Default: )
  -i, --filename=<s>        Filename of the output CSV file (optional)
  -c, --club-id=<i>         Strava club ID (default: 25174)
  -h, --help                Show this message

```

```
Examples:
bundle exec ruby bin/club_activities -a <access_token> -f <filter_text>
```

## Deployment

For ease of use, this is actually deployed as a one click windows app.

In windows do the following:

1. Install ruby 2.5 in windows
2. Run the following commands:
    ```shell
    gem install ocra
    ocra bin/club_activities
    ```
3. club_activities.exe will be generated and is self sufficient with all dependencies packed up
4. run as per instructions above like this
    ```shell
    club_activities.exe -m <mode> -a <access_token> -f <filter_text>
    ```

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `bundle exec rake` to run the tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/stephenwong/strava_club_activities. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/strava_club_activities/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the StravaClubActivities project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/strava_club_activities/blob/master/CODE_OF_CONDUCT.md).
