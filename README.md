# ascope-conky-ctftime

This repository contains a conky script to gather the latest ctftime.org upcoming, running and past events. By default, it sets to list the events 2 weeks before the current time and 3 weeks after it, but it can be tweaked within the [ctftime.sh](https://github.com/Ascope-Team/ascope-conky-ctftime/blob/master/ctftime.sh) script, see the variables [`N_BEFORE_WEEK`](https://github.com/Ascope-Team/ascope-conky-ctftime/blob/master/ctftime.sh#L26) or [`N_AFTER_WEEK`](https://github.com/Ascope-Team/ascope-conky-ctftime/blob/master/ctftime.sh#L27).

```text
Requirement: conky
```

## Current release notes

The release v2 uses the ctftime.org ([api v1](https://ctftime.org/api/)) rather than parsing the upcoming events [rss](https://ctftime.org/event/list/upcoming/rss/).

If you have any suggestions or improvement about the script, file an [issue](https://github.com/Ascope-Team/ascope-conky-ctftime/issues) or contact us privately.

## Preview

![preview](ascope_conky_preview.png)

## License
conky - GPL and BSD licenses  
ascope - same license as well for this project
