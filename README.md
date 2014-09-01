# Members' dates

### A redmine plugin by Espeo Software.

Adds a `starts_on` and `ends_on` date fields to a `Member` relation.

That is, besides setting user's role on a specific project, you can also set his start & end date when he'll be an actual member of the project.

**IMPORTANT**: Currently those dates are only for a view & edit use. They don't change any current behaviours of Redmine. **That may be changed in the future.**

### Installation

1. Copy this plugin's contents or check out this repository into `/redmine/plugins/espeo_members_dates` directory.

2. Run `bundle exec rake redmine:plugins:migrate`.
