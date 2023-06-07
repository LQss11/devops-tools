# Configuration
Usually to setup nginx you will need:
- events {}
- http {server{location{}}}

And those are essentials but needs improvement.

## Location Blocks
| Matches order                        | example |
| ------------------------------------ | ------- |
| Exact Match                          | = uri   |
| Preferential Prefix match            | ^~ uri  |
| REGEX match (* for case insensitive) | ~* uri  |
| Prefix match                         | uri     |