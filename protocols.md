# Race Protocol
The following is a series of commands that can be used to manage, participate, and execute races.

## Management
- CREATE <name> [options] -> <identifier> | :error
  Instantiates a new Race with the given `name`, as well as any other options. `name` will be used when displaying the race publicly, along with additional options as they become available. As such, `name` must be unique among the current set of active races.

  Options can include:
    - `game`: the game being played in the race.
    - `category`: the category being run in the race.
    - `capacity`: the maximum number of participants the race will allow.
    - `visibility`: the visibility level of the race. Can be either `public` or `private`.
    - `password`: the password needed to join the race. If given as NULL, no password will be required to join.

  The created race will be owned by the user who caller of this method.

  On success, the generated identifier for the Race will be returned. If an error occurs, `:error` will be returned instead.


- MODIFY <identifier> [options] -> <identifier> | :error
  Modify the Race identified by `identifier` with the given options. Only the race owner can modify the race.

  Options can include:
    - `game`: the game being played in the race.
    - `category`: the category being run in the race.
    - `capacity`: the maximum number of participants the race will allow.
    - `visibility`: the visibility level of the race. Can be either `public` or `private`.
    - `password`: the password needed to join the race. If given as NULL, no password will be required to join.

  On success, the identifier for the Race will be returned. If an error occurs, `:error` will be returned instead.


- DELETE <identifier> [reason] -> :success | :error
  Destroy the Race identified by `identifier`. If `reason` is given, it will be shown to all participants in the race; if omitted, a default message of "This race has been deleted by the race owner."

  Only the race owner can delete the race.

  On success, `:success` will be returned. If an error occurs, `:error` will be returned instead.


## Participation
- JOIN <name> [password] -> :success | :error
  Add the caller of this method to the list of participants in the race identified by `name`. For locked races, `password` must be provided and must match the password of the requested race.

  On success, `:success` will be returned. If an error occurs, `:error` will be returned instead. Errors may occur


- LEAVE <name> -> :success | :error
  Remove the caller of this method from the list of participants in the race identified by `name`.

  On success, `:success` will be returned. If an error occurs, `:error` will be returned instead.


- OBSERVE <name> -> :success | :error
  Add the caller of this method to the list of observers for the race identified by `name`. Observers will receive live updates for the race, but are unable to push updates to the race.

  This behavior can be useful particularly for private races where an independent moderator is desired. The moderator should be able to observe the race as it is happening, but is not a participant, and does not need to push updates to the race.

  For public races, anyone viewing the race in realtime (through spdrns.com, for example) will be given the "observer" role via an implicit call to this method.

  On success, `:success` will be returned. If an error occurs, `:error` will be returned instead.


## Execution
- READY <name> -> :success | :error
  Mark the caller of this method as "ready" for the start of the race identified by `name`. Once all participants in a race are marked as "ready", the race will move to a "pre-start" state.

  On success, `:success` will be returned. If an error occurs, `:error` will be returned instead.


- UNREADY <name> -> :success | :error
  Unmark the caller of this method as "ready" for the start of the race identified by `name`. Unmarking can happen until a race reaches the "started" state. After this point, any calls to this method will return `:error`.

  On success, `:success` will be returned. If an error occurs, `:error` will be returned instead.


- FORFEIT <name> -> :success | :error
  Mark the caller of this method as "forfeiting" the race identified by `name`. Forfeiting a race does not remove the caller from the race, but will exclude them from any side-effects the race may have.

  On success, `:success` will be returned. If an error occurs, `:error` will be returned instead.
