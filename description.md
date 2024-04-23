### DSL Description:

The DSL allows for creating, reading, updating, and deleting nodes in a structured data format. Each operation is represented by a specific character at the beginning of a line: `+` for create, `@` for read, `^` for update, and `-` for delete. Nodes are identified by paths (dot-separated strings) or integer IDs.

#### Grammar Elements:

1. **Operations**:
   - `+` (Create): Add a new node or update an existing one.
    - followed by optional identification
    - then followed by optional key value pair(s)
   - `@` (Read): Retrieve data from a node.
    - followed by identification
    - then optional : key
   - `^` (Update): Modify attributes of a node.
    - followed by identification
    - then optional key value pair(s)
   - `-` (Delete): Remove a node or an attribute.
    - followed by identification
    - then followed

2. **Identification**:
    - can be a path or a integer id
   - Path: Dot-separated strings (`user.profile.address`) or a single name `user`.
   - Integer ID: Plain integers (`123`).

3. **Key-Value Pairs**:
   - Used in create and update operations.
   - Consist of a key followed by a colon (`:`) and a value.

4. **Value**:
   - Integer: Plain integer (`123`).
   - Float: Floating-point number (`123.45`).
   - String: Quoted or unquoted single word(not all numbers) (`"example"` or `example`).
   - Node reference: Referenced by `@` followed by an identification.
   - New node: key value pair(s) wrapped in {}. ex: `{key: value}`
   - List: Enclosed in square brackets, containing values separated by spaces. Lists cannot contain another list.

Got it! Let’s refine the examples to correctly utilize the key-value format where the node creation is treated as a value with a preceding key. Additionally, I'll show how unquoted single-word strings can be used as values:
