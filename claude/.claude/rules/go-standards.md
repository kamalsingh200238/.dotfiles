---
paths:
  - '**/*.go'
---

# Go Standards - post-write checklist

- When this file is loaded, acknowledge it by saying: "read go standards from rules"
- These rules apply to new or changed Go code only.
- Do not rewrite existing code solely to match these rules unless the user asks for it.
- After writing or editing Go code, verify every item below against your changes before reporting work as done.
  If any item is violated, fix it before proceeding.

## Checklist

### File naming
- [ ] All file names are `snake_case`.

### Visibility
- [ ] Structs, types, interfaces, functions are **unexported** until needed by another package.
- [ ] Struct fields are **exported** by default (required for `encoding/json`, zerolog, reflection). Unexported only
  with a specific reason.

### Structs
- [ ] Structs with 6-8+ fields are passed by pointer.
- [ ] Structs with required fields or invariants have a `newXxx()` constructor.
- [ ] No `init()`. Use `newXxx()` constructors.

### Loops and slices
- [ ] Range loops use index-only, access via `items[i]`. No value variable from `range` unless user asks.
- [ ] Slices are preallocated when length is known: `make([]T, 0, n)`.

### Context
- [ ] `context.Context` is propagated from caller. `context.Background()`/`context.TODO()` only at entry points
  (`main`, handlers, tests).

### Control flow
- [ ] Early returns with guard clauses. No `else` after error/edge-case `if`.

### Error handling
- [ ] `err` is reused with `=`. No `readErr`, `writeErr` variants.
- [ ] Errors are wrapped: `fmt.Errorf("failed to <action>: %w", err)`.
- [ ] `errors.Is()` / `errors.As()` used for comparison. No string comparison, no manual type assertion.

### Enums
- [ ] No `iota`, no string constants. Struct-based pattern used:

```go
type color struct{ name string }

func Red() color   { return color{name: "Red"} }
func Green() color { return color{name: "Green"} }

func (c color) String() string                { return c.name }
func (c color) Equals(o color) bool           { return c.name == o.name }
func ParseColor(s string) (color, error)      { ... }
func (c color) MarshalJSON() ([]byte, error)  { ... }
func (c *color) UnmarshalJSON(b []byte) error { ... }
```
