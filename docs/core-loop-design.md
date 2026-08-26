# Core Loop Design — Version 0.1

## Design Intent

The game is a single-player, short-session stealth platformer for Android and Web/Wasm. Each raid takes place in a pre-built urban-fantasy fortress and is designed to be completed in under three minutes. The player controls an agile thief who is learning to become an infiltrator.

## Core Loop

| Step | Player action | Immediate feedback | Longer-term consequence |
|---|---|---|---|
| 1. Select | Choose a fortress and review its reward and ghost benchmark | Threat, reward, and target score are legible | Player chooses risk versus reward |
| 2. Enter | Begin the infiltration with jump/acrobatic movement, wall-grab, and slide | Responsive movement and readable stealth spaces | Player learns the fortress grammar |
| 3. Read | Identify guards, traps, secret routes, magical graffiti, and escape alternatives | Information creates meaningful route choices | Player improves mastery and route knowledge |
| 4. Traverse | Use movement abilities and temporary graffiti-created shortcuts while avoiding detection | Momentum, silence, and proximity create tension | Faster and cleaner routes become possible |
| 5. React | If detected, enter a chase and select an alternative route to escape | Pursuit gives urgency without automatic failure | Recovery skill becomes part of mastery |
| 6. Steal | Reach the target and secure treasure | Strong audiovisual payoff marks the heist | Treasure feeds the reward economy |
| 7. Escape | Return through the fortress or use a discovered exit route | Tension peaks after the theft | Successful extraction determines the final run result |
| 8. Compare | View the ghost silhouette and the combined score | Player sees where time, treasure, or failures affected performance | Clear reason to replay or advance |
| 9. Progress | Spend rewards on storage, new areas, abilities, reputation, and visual customization | Base visibly changes and new options open | Long-term identity and progression |

## Ghost Score — Confirmed Formula Direction

The client selected a combined score with an initial weighting of **40% time, 40% treasure, and 20% failures**. Exact normalization, score caps, tie-breaking, and user-facing presentation remain **[VALIDATION REQUIRED]**.

The score should remain independent from optional-ad rewards. Watching an optional advertisement may grant a treasure bonus or a second chance, but it must not directly increase the ghost score. A second chance restarts the player at a checkpoint and applies a score penalty.

## Stealth and Chase Model — Confirmed Direction

Detection does not immediately end the raid. It starts a pursuit in which the player can escape by choosing alternative routes. This design makes route reading a core skill and preserves the short-session rhythm. The number, visibility, and relative risk of alternative routes remain to be tuned through playtesting.

## Magic Graffiti — Confirmed Direction

Magical graffiti is the signature urban-fantasy system. It performs three related functions: it reveals secret routes, creates temporary platforms or shortcuts, and alters traps. The MVP should introduce these functions progressively so that the player first understands the visual language, then uses it to make a deliberate route choice, and finally combines it with movement abilities during a chase.

## Progression and Base — Confirmed Direction

The base combines functional and visual progression. The initial functional improvements are larger treasure storage, access to new areas, and new abilities. Visual customization provides ownership and identity without affecting ghost competition. The exact resource costs, unlock order, and economy rates remain open.

## Monetization Boundary — Confirmed Direction

Monetization combines cosmetic purchases with optional advertisements. Optional advertisements may offer a second chance after capture or a treasure bonus. The competitive score must be calculated before any economic bonus and must record a penalty when a second chance is used. No monetized item should provide a direct advantage in ghost competition.

## Vertical Slice Target

The award-focused vertical slice should present one compact fortress with the following sequence: the thief enters an urban-fantasy space marked by magical graffiti; learns one movement interaction; uses jump, wall-grab, and slide to overcome a readable obstacle; discovers a secret shortcut; triggers a chase; escapes through an alternative route; steals the first treasure; and sees a ghost silhouette plus a clear combined-score result. The base screen should then show at least one visible customization change and one functional unlock path.

## Open Balancing Parameters

| Parameter | Current status |
|---|---|
| Raid duration | Confirmed target: under three minutes |
| Ghost score weights | Initial proposal confirmed: 40/40/20; normalization open |
| Chase duration | Unknown |
| Number of alternative routes | Unknown |
| Failure cost without second chance | Unknown |
| Second-chance score penalty | Unknown |
| Graffiti duration and cooldown | Unknown |
| Treasure storage capacity | Initial value unknown |
| Unlock costs and pacing | Unknown |
| Cosmetic catalog size for MVP | Unknown |
