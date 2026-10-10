# standard-studio

ITSUSSTUDIO rules for [Standard Ruby](https://github.com/standardrb/standard), packaged as a Standard plugin.

## Install

Gemfile, development group:

    gem "standard-studio", github: "itsusstudio/standard-studio", require: false

That one line brings the whole lint stack: `standard`, `standard-rails`, `rubocop-factory_bot` and `rubocop-rake` are dependencies of this gem, so an app does not list them. `standard-performance` and `standard-custom` come with Standard itself.

An app that needs a particular version of one of them adds its own line beside this one, for example `gem "standard", "1.56.0"`.

Because those gems are no longer direct dependencies, Dependabot stops opening routine update pull requests for them. They move when you run `bundle update standard-studio`, or `bundle update standard` by name.

Standard has no way to share one `.standard.yml` between repositories, and a plugin cannot switch on other plugins, so each app still lists its plugins itself.

## Example `.standard.yml`

A complete file for a studio Rails app:

    ignore:
      - "db/schema.rb":
        - Rails/CreateTableWithTimestamps

    plugins:
      - standard-studio
      - standard-rails
      - rubocop-factory_bot
      - rubocop-rake

- `standard-studio` goes first. Standard plugins are first in wins: once one plugin configures a rule, a later one cannot change it.
- `ignore` is per app. `db/schema.rb` is generated, so the one rule that misfires on it is switched off there.
- Nothing else is needed. The plugin class is named in the gemspec, so there is no `require_path` or `plugin_class_name` to set.

## Adopting it in an app that does not pass yet

    bundle exec standardrb --fix
    bundle exec standardrb --generate-todo

The first fixes what is safe to fix. The second writes `.standard_todo.yml`, which ignores the remaining offenses file by file while new ones still fail. Commit it, and delete entries as files are cleaned up.

## Rules

Standard pins many built-in RuboCop cops to off and does not let a plugin switch them on. Where a rule below says "inherits", it is the built-in cop under a name Standard does not own.

### Studio/ClassStructure

Inherits `Layout/ClassStructure`. Class contents go in this order:

1. `include`, `extend`, `prepend`
2. Constants
3. Attribute macros: `attribute`, `enum`, `store_accessor`
4. Associations
5. Validations
6. Callbacks
7. Class methods
8. `initialize`
9. Public methods
10. Protected methods
11. Private methods

Macros not named in `config/base.yml` (`scope`, `normalizes`, `delegate`, `generates_token_for`, `attr_reader` and so on) are not checked, so they can sit where they read best.

Autocorrect is unsafe. It moves lines but drops the blank lines between groups, and the order of callbacks can change behaviour, so read the diff.

### Studio/ClassMethodsDefinitions

Inherits `Style/ClassMethodsDefinitions`. Class methods go inside `class << self`, never `def self.name`, even when there is only one. `private` works inside the block; above a `def self.` it does nothing. No autocorrect.

### Studio/NoUnless

Use `if !` instead of `unless`. Autocorrects, wrapping compound conditions in parentheses: `unless a && b` becomes `if !(a && b)`. An `unless` with an `else` is flagged but left for Standard's own `Style/UnlessElse` to rewrite first.

### Studio/WordArray and Studio/SymbolArray

Inherit `Style/WordArray` and `Style/SymbolArray` with the `brackets` style. Write `["a", "b"]` and `[:a, :b]`, not `%w[a b]` and `%i[a b]`. Autocorrects.
