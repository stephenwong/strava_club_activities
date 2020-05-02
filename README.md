# StravaClubActivities

This tool downloads the club activities using the strava API and generates a CSV file for processing virtual race events.

## Usage
Running it locally can be done like this:
```
bundle exec ruby bin/club_activities -h

Options:
  -a, --access-token=<s>    Strava access token (default: )
  -f, --filter=<s>          Description to filter by (case-insensitive) (default: )
  -c, --club-id=<s>         Strava club ID (default: 25174)
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
    club_activities.exe -a <access_token> -f <filter_text>
    ```

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `bundle exec rake` to run the tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/stephenwong/strava_club_activities. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/strava_club_activities/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the StravaClubActivities project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/strava_club_activities/blob/master/CODE_OF_CONDUCT.md).
