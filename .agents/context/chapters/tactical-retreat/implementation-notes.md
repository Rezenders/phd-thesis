# Tactical Retreat implementation notes

Excerpt of the paper repo's `.agents/context/paper-model.md` (2026-11-05), paths
rewritten to absolute workspace paths.

## Implementation References

Use implementation files as read-only ground truth when manuscript claims depend on them. Do not propose code changes during paper tasks.

| What to verify | Where to look |
|---|---|
| Type names, relations, model structure | `~/ros_workspaces/suave_rebetmc_ws/src/typedb_tactics/schemas/` |
| Running example instances (paper's robot scenario) | `~/ros_workspaces/suave_rebetmc_ws/src/typedb_tactics/schemas/relaxed/relaxed_paper_example.tql` |
| Runtime behavior, interface method names | `~/ros_workspaces/suave_rebetmc_ws/src/typedb_tactics/typedb_tactics/typedb_tactical_retreat_interface.py` |
| Design notes and module overview | `~/ros_workspaces/suave_rebetmc_ws/src/typedb_tactics/README.md`, `~/ros_workspaces/suave_rebetmc_ws/src/typedb_tactics/docs/agent-notes.md` |

## High-Risk Interfaces

- `applicable_tactic_rules` (paper) vs `applicable_tactics` (implementation); `tactic_rule_target_node` (paper) vs `tactic_target_node` (implementation). The paper intentionally uses the more descriptive names.
- `applicable_tactic_rules` selects rules whose target is the host node itself OR any node in `connected_nodes(host)`. The host-equality branch (`same_node(H,TN)`) is separate from reachability and easy to omit.
- `interface_hosts` covers three interface types: ActionServer, ServiceServer, and Publisher. Descriptions listing only two are incomplete.
- `InferenceRules` blocks are pedagogical Datalog, not TypeQL. Accepted abstractions: `node_running(N)` (abstracts `not end_time(N,_)`), two-argument `set_nodes_parameters(RA,N)` (schema relation has three roles), `resolution_action_of(VR,RA)` (abstracts the `resolution_action` role in `variant_resolution`), and pedagogical helpers `afferent_of`, `efferent_of`, `same_node`, `direct_neighbours`. Fact tables may be omitted when the predicate name is self-explanatory (e.g. `lifecycle_transition_allowed`). Do not flag these as divergences.

## Presentation conventions

Do not flag readability-oriented ROS/DSL name normalization as an implementation discrepancy unless it changes meaning or creates ambiguity:

- Generated `_slash_...` identifiers may be rendered as conventional ROS names with `/`.
- Compact examples may omit a redundant `_node` suffix, such as `/water_visibility_observer.diagnostics` for the `/water_visibility_observer_node` diagnostic source.
- Ordinary prose about "performing the action to search for the pipeline" can mean the managed mission behavior, rather than a ROS action server or a resolution action, when context is clear.
