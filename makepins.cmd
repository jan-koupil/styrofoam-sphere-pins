FOR %%G IN (
    zero,
    one,
    plus,
    minus,
    minus_i,
    plus_i
) DO ("c:\Program Files\OpenSCAD\openscad.exe" -o %%G.stl -D "label=""%%G""" narrow_pin.scad)

@REM FOR %%G IN (
@REM     plus_wide,
@REM     minus_wide,
@REM     plus_i_wide,
@REM     minus_i_wide
@REM ) DO ("c:\Program Files\OpenSCAD\openscad.exe" -o %%G.stl -D "label=""%%G""" wide_pin.scad)

FOR %%G IN (
    x, plus_x, minus_x,
    y, plus_y, minus_y,
    z, plus_z, minus_z
) DO ("c:\Program Files\OpenSCAD\openscad.exe" -o %%G.stl -D "label=""%%G""" axis_pin.scad)

