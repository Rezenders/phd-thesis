# Terminology

## Canonical Names and Macros

| Concept | Required form | Notes |
|---|---|---|
| Approach | `\approachname` → `Tactical Retreat` | Always use the macro |
| Number of models | `\numberofmodels` → `six` | Always use the macro |
| Architectural Adaptation Layer | `\aal` → `AAL` | |
| Adaptation decorator | `\adapdec` → `AdaptDecorator` | Decorates a *managed action* |
| QR decorator | `\qrdec` → `QRDecorator` | |
| Blackboard | `\bb` → `Blackboard` | |
| TypeDB's reasoning component | reasoner | Not "engine", "reasoning engine", or "inference engine" |
| Fuzzy requirement evaluation output | satisfaction degree | Not "fulfillment degree" |
| Runtime RELAX rewrite process | time-degeneration | |
| Evaluation modes | runtime evaluation / post-execution evaluation | Two distinct modes |
| Runtime models | Architecture, Variability, Resolution, Context, Requirements and Tactic models | |

Custom DSL listing languages are defined in `preamble.tex`, including `Tactic`, `Requirements`, `Architecture`, `ArchitectureRosSystem`, `Variability`, `Resolution` and `Context`. Inspect current definitions before using language/style names.

## Acronyms

| Acronym | Expansion | First-use rule |
|---|---|---|
| AAL | Architectural Adaptation Layer | Use `\aal` |
| FBTL | fuzzy branching temporal logic | Cite `\cite{fbtl}` |
| RELAX | RELAX requirements language | Cite `\cite{whittle2010relax}` |
| PERA | polymorphic entity-relation-attribute | Verify first active use in the selected entry; historical TypeDB background is currently commented in `sections/background.tex` |
| KR&R | knowledge representation and reasoning | |
| NAF | negation-as-failure | Verify first active use; historical inference-rule exposition is commented in `sections/approach-cbr.tex` |

## Notation

- `\phi` — pre-rewrite FBTL formula; `\hat{\phi}` — time-degenerated formula
- `u_t(\hat{\phi}) \in [0,1]` — pointwise satisfaction degree at time `t` (runtime evaluation)
- `u(\cdot)` — trace-level satisfaction degree (post-execution evaluation)
- `\hat{u}_t(\phi \mid TR)` — hypothetical satisfaction degree under tactic rule `TR` (Retrieving Tactics). Do not confuse with `u_t(\hat{\phi})`.
- Connectives: `\min` for conjunction, `\max` for disjunction, `1 - u_t` for negation
- Time-degeneration rewrites: `A \pi \mapsto \pi`, `G \phi \mapsto \phi`, `F \phi \mapsto \phi`; `EVENTUALLY \phi` is deferred to post-execution evaluation
- Trace semantics: `u(F\phi) = \max_{0 \le t \le T} u_t(\phi)`, `u(G\phi) = \min_{0 \le t \le T} u_t(\phi)`
- Objective function `J`

## Distinctions to Preserve

- "Action" has three meanings: *managed action* (behavioral task decorated by an `AdaptDecorator`), *action server* (ROS communication interface type), *resolution action* (adaptation step in the resolution model). Conflating these caused reviewer confusion.
- `tactic rules`, `applicable tactic rules`, and `valid tactic rules` are distinct stages.
- Q-Task, Q-Arch, F-Task, F-Arch are distinct requirement categories.
- NAF framing: describe default-true NAF rules as "X is presumed Y by default and is marked not-Y only when ...", not as "X is Y when all Z are Y".

## Forbidden or Discouraged Variants

- Do not use "engine" or "inference engine" for the TypeDB reasoner.
- Do not use "fulfillment degree"; use "satisfaction degree".
- Do not introduce "logical rules" as a new term; the manuscript uses "inference rules" and "tactic rules".
- Do not use a technical term before it is defined earlier in the text; grep the manuscript to verify.
