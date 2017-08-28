#!/usr/bin/env stack
{- stack
    --resolver lts-7.24
    --install-ghc
    runghc
    --package Chart
    --package Chart-cairo
-}

{-# LANGUAGE OverloadedStrings #-}

import System.Environment

import Graphics.Rendering.Chart.Easy hiding (line)
import Graphics.Rendering.Chart.Backend.Cairo

line title values = liftEC $ do
    color <- takeColor
    plot_lines_title .= title
    plot_lines_values .= values
    plot_lines_style . line_color .= color
    plot_lines_style . line_width .= 2.5

main :: IO ()
main = do
  toFile def "img/relu.png" $ do
    layout_all_font_styles . font_size .= 48
    layout_all_font_styles . font_name .= "Latin Modern Roman"
    layout_title_style . font_weight .= FontWeightNormal
    layout_title .= "rectified linear"
    layout_x_axis . laxis_title .= "x"
    layout_y_axis . laxis_title .= "y"
    layout_y_axis . laxis_generate .= scaledAxis def (-10, 10)
    setColors [opaque black]
    plot $ line "" [[(-10 :: Double, 0 :: Double), (0, 0), (10, 10)]]
  toFile def "img/sigmoid.png" $ do
    layout_all_font_styles . font_size .= 48
    layout_all_font_styles . font_name .= "Latin Modern Roman"
    layout_title_style . font_weight .= FontWeightNormal
    layout_title .= "sigmoid"
    layout_x_axis . laxis_title .= "x"
    layout_y_axis . laxis_title .= "y"
    layout_y_axis . laxis_generate .= scaledAxis def (-2, 2)
    setColors [opaque black]
    let tics = [-10,-9.5..10] :: [Double]
        e = exp 1
        sigmoid x = 1 / (1 + e ** (-x))
    plot $ line "" [zip tics $ map sigmoid tics]
  toFile def "img/tanh.png" $ do
    layout_all_font_styles . font_size .= 48
    layout_all_font_styles . font_name .= "Latin Modern Roman"
    layout_title_style . font_weight .= FontWeightNormal
    layout_title .= "hyperbolic tangent"
    layout_x_axis . laxis_title .= "x"
    layout_y_axis . laxis_title .= "y"
    layout_y_axis . laxis_generate .= scaledAxis def (-2, 2)
    setColors [opaque black]
    let tics = [-10,-9.5..10] :: [Double]
        e = exp 1
    plot $ line "" [zip tics $ map tanh tics]
