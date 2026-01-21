#let body-font = "PayPal Sans Small"

#set text(font: body-font)

#table(
  columns: 2,
  fill: (_, y) => if calc.odd(y) { white } else { rgb("#f0f8ff") },
  [*Month*], [*Sales*],
  [Jun], [342],
  [Jul], [275],
  [Aug], [378],
  [Sep], [282],
  [Oct], [215],
  [Nov], [237],
  [Dec], [312],
  [Jan], [331],
  [Feb], [321],
  [Mar], [358],
  [Apr], [348],
  [May], [387],
)
