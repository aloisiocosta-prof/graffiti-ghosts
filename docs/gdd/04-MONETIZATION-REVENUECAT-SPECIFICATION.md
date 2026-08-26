# 04 — MONETIZATION + REVENUECAT SPECIFICATION

## Status

`[VALIDATION REQUIRED]` Monetização não está aprovada para o MVP atual, e os produtos/preços do relatório são exemplos genéricos.[1]

## 1. Business Model

| Campo | Estado |
|---|---|
| Modelo | `[DECIDIR]` F2P, premium ou híbrido |
| Monetização primária | `[VALIDATION REQUIRED]` |
| Monetização secundária | `[VALIDATION REQUIRED]` |
| Plataforma de compra | Android/loja a confirmar; Web/WasmGC não deve presumir billing Android |

## 2. Catalog

| ID | Store Product | RevenueCat Product | Package | Offering | Entitlement | Feature | Status |
|---|---|---|---|---|---|---|---|
| MON-001 | `[DECIDIR]` | `[DECIDIR]` | `[DECIDIR]` | `[DECIDIR]` | `[DECIDIR]` | `[DECIDIR]` | VALIDATION REQUIRED |

## 3. Entitlement Contract

```text
STORE PRODUCT
→ REVENUECAT PRODUCT
→ PACKAGE/OFFERING
→ ENTITLEMENT
→ FEATURE ACCESS
```

O domínio deve depender de um `MonetizationPort`, enquanto o RevenueCat permanece em um adapter de infraestrutura; nenhum tipo do SDK pode vazar para domain/application.[5]

## 4. Purchase State Machine

```text
UNKNOWN → LOADING → AVAILABLE → PURCHASING → CONFIRMED → ENTITLEMENT_ACTIVE
                                      ├→ FAILED
                                      └→ CANCELLED
CONFIRMED → SYNC_REQUIRED → ENTITLEMENT_ACTIVE
```

## 5. Restore / Sync

`restorePurchases` deve ser uma ação explícita do usuário, e qualquer sincronização automática deve seguir uma decisão de lifecycle e autoridade de dados.[1]

Os comportamentos para offline, troca de usuário, reinstalação, refund, expiration e identidade permanecem `[VALIDATION REQUIRED]`.[1]

## 6. Monetization Integrity Invariants

- [ ] Operações idempotentes.
- [ ] Retry não duplica benefício.
- [ ] Entitlement não depende somente de cache de UI.
- [ ] Compra confirmada não é perdida por background.
- [ ] Restore possui teste.
- [ ] Identidade possui regra explícita.

## 7. Ethical Constraints

A monetização não pode ser necessária para compreender o jogo, completar a raid básica ou corrigir um core loop sem diversão.[1]

## 8. Acceptance Criteria

A implementação somente poderá iniciar após produto, preço, entitlement, plataforma, autoridade, consentimento, restore e testes de falha serem aprovados pelo cliente.[1] [5]

## Referências

[1]: ../references/deep-research-report.md "Relatório de pesquisa fornecido pelo usuário"
[2]: ../concept-brief.md "Graffiti Ghosts concept brief"
[3]: ../core-loop-design.md "Graffiti Ghosts core-loop design"
[4]: ../technical-and-demo-spec.md "Graffiti Ghosts technical and demo specification"
[5]: ../../.agents/skills/graffiti-ghosts-agentic-game-development/SKILL.md "Graffiti Ghosts agentic development rules"
