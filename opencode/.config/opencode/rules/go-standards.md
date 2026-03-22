---
globs:
  - "**/*.go"
---

# Go Standards — mandatory, follow strictly.

- When this file is loaded, acknowledge it by saying: "read go guidelines from rules"

## File Naming
- `snake_case` for all file names.

## Good Practices
- Structs, types, interfaces, functions: **unexported** until needed by another package.
- Struct fields: **exported** by default (required for `encoding/json`, zerolog, reflection). Unexport only with a specific reason — the unexported struct already gates external access.
- Structs with 6-8+ fields: pass by pointer.
- Range loops: index-only, access via `items[i]`. No value variable from `range` unless user asks.
- Always propagate `context.Context` from caller. `context.Background()`/`context.TODO()` only at entry points (`main`, handlers, tests).
- No `init()`. Use `newXxx()` constructors.
- Preallocate slices when length is known: `make([]T, 0, n)`.
- Early returns with guard clauses. No `else` after error/edge-case `if`.
- Provide `newXxx()` for structs with required fields or invariants.

## Enums
No `iota`, no string constants. Struct-based pattern:
- Unexported struct, unexported fields.
- Values as **functions** (not `var`).
- Methods: `String()`, `Equals(other) bool`, `ParseXxx(string) (Xxx, error)`, `MarshalJSON()`, `UnmarshalJSON()`.

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

## Error Handling
- Reuse `err` with `=`. No `readErr`, `writeErr` variants.
- Always wrap: `fmt.Errorf("failed to <action>: %w", err)`.
- Always use `errors.Is()` / `errors.As()`. No string comparison, no manual type assertion.
