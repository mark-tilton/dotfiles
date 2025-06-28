local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
  topmost = "window",
  height = 38,
  color = colors.with_alpha(colors.bg2, 0.9),
  padding_right = 5,
  padding_left = 5,
  blur_radius = 0,
  shadow = false,
  y_offset = 0,
  margin = 0,
  corner_radius = 0,
  background_color = colors.with_alpha(colors.bar.bg, 0.40),
})
