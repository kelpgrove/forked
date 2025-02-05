# Conditional Elements

## Test 1: Interpolation:

<:
"1 During"
:>

[Next](#)

<: 
```rb
    putz args.outputs.primitives[2...3]
    subject = args.outputs.primitives[2...3]
    expect = [{:x=>200, :y=>604, :text=>"1 During ", :primitive_marker=>:label, :font=>"fonts/Roboto/Roboto-Regular.ttf", :size_enum=>0, :line_spacing=>1, :r=>204, :g=>204, :b=>204, :spacing_between=>0.6, :spacing_after=>0.9, :size_px=>22.0}]
    expect == subject ? "Test passed " : "Test failed"
```
:>

## Test 2: Interpolation after text

2 Before
<:
"2 During"
:>

[Next](#)

<: 
```rb
    subject = args.outputs.primitives[2...4]
    expect = [{:x=>200, :y=>604, :text=>"2 Before ", :primitive_marker=>:label, :font=>"fonts/Roboto/Roboto-Regular.ttf", :size_enum=>0, :line_spacing=>1, :r=>204, :g=>204, :b=>204, :spacing_between=>0.6, :spacing_after=>0.9, :size_px=>22.0}, {:x=>274, :y=>604, :text=>"2 During ", :primitive_marker=>:label, :font=>"fonts/Roboto/Roboto-Regular.ttf", :size_enum=>0, :line_spacing=>1, :r=>204, :g=>204, :b=>204, :spacing_between=>0.6, :spacing_after=>0.9, :size_px=>22.0}]
    expect == subject ? "Test passed " : "Test failed"
```
:>

## Test 3: Interpolation before text

<:
"3 During"
:>
3 After

[Next](#)

<: 
```rb
    subject = args.outputs.primitives[2...4]
    expect = [{:x=>200, :y=>604, :text=>"3 During ", :primitive_marker=>:label, :font=>"fonts/Roboto/Roboto-Regular.ttf", :size_enum=>0, :line_spacing=>1, :r=>204, :g=>204, :b=>204, :spacing_between=>0.6, :spacing_after=>0.9, :size_px=>22.0}, {:x=>274, :y=>604, :text=>"3 After ", :primitive_marker=>:label, :font=>"fonts/Roboto/Roboto-Regular.ttf", :size_enum=>0, :line_spacing=>1, :r=>204, :g=>204, :b=>204, :spacing_between=>0.6, :spacing_after=>0.9, :size_px=>22.0}]
    expect == subject ? "Test passed " : "Test failed"
```
:>

## Test 4: Interpolation after and before text

4 Before
<:
"4 During"
:>
4 After

[Next](#)

<: 
```rb
    subject = args.outputs.primitives[2...5]
    expect = [{:x=>200, :y=>604, :text=>"4 Before ", :primitive_marker=>:label, :font=>"fonts/Roboto/Roboto-Regular.ttf", :size_enum=>0, :line_spacing=>1, :r=>204, :g=>204, :b=>204, :spacing_between=>0.6, :spacing_after=>0.9, :size_px=>22.0}, {:x=>274, :y=>604, :text=>"4 During ", :primitive_marker=>:label, :font=>"fonts/Roboto/Roboto-Regular.ttf", :size_enum=>0, :line_spacing=>1, :r=>204, :g=>204, :b=>204, :spacing_between=>0.6, :spacing_after=>0.9, :size_px=>22.0}, {:x=>349, :y=>604, :text=>"4 After ", :primitive_marker=>:label, :font=>"fonts/Roboto/Roboto-Regular.ttf", :size_enum=>0, :line_spacing=>1, :r=>204, :g=>204, :b=>204, :spacing_between=>0.6, :spacing_after=>0.9, :size_px=>22.0}]
    expect == subject ? "Test passed " : "Test failed"
```
:>

## Test 5: Conditional

<:
true
::
5 During
:>

[Next](#)

<: 
```rb
    putz subject = args.outputs.primitives[2...3]
    expect = [{:x=>200, :y=>604, :text=>"5 During ", :primitive_marker=>:label, :font=>"fonts/Roboto/Roboto-Regular.ttf", :size_enum=>0, :line_spacing=>1, :r=>204, :g=>204, :b=>204, :spacing_between=>0.6, :spacing_after=>0.9, :size_px=>22.0}]
    expect == subject ? "Test passed " : "Test failed"
```
:>

## Test 6: Conditional after text

6 Before
<:
true
::
6 During
:>

[Next](#)

<: 
```rb
    putz subject = args.outputs.primitives[2...4]
    expect = [{:x=>200, :y=>604, :text=>"6 Before ", :primitive_marker=>:label, :font=>"fonts/Roboto/Roboto-Regular.ttf", :size_enum=>0, :line_spacing=>1, :r=>204, :g=>204, :b=>204, :spacing_between=>0.6, :spacing_after=>0.9, :size_px=>22.0}, {:x=>274, :y=>604, :text=>"6 During ", :primitive_marker=>:label, :font=>"fonts/Roboto/Roboto-Regular.ttf", :size_enum=>0, :line_spacing=>1, :r=>204, :g=>204, :b=>204, :spacing_between=>0.6, :spacing_after=>0.9, :size_px=>22.0}]
    expect == subject ? "Test passed " : "Test failed"
```
:>

## Test 7: Conditional before text

<:
true
::
7 During
:>
7 After

[Next](#)

<: 
```rb
    putz subject = args.outputs.primitives[2...4]
    expect = [{:x=>200, :y=>604, :text=>"7 During ", :primitive_marker=>:label, :font=>"fonts/Roboto/Roboto-Regular.ttf", :size_enum=>0, :line_spacing=>1, :r=>204, :g=>204, :b=>204, :spacing_between=>0.6, :spacing_after=>0.9, :size_px=>22.0}, {:x=>274, :y=>604, :text=>"7 After ", :primitive_marker=>:label, :font=>"fonts/Roboto/Roboto-Regular.ttf", :size_enum=>0, :line_spacing=>1, :r=>204, :g=>204, :b=>204, :spacing_between=>0.6, :spacing_after=>0.9, :size_px=>22.0}]
    expect == subject ? "Test passed " : "Test failed"
```
:>

##Test 8: Conditional after and before text

8 Before
<:
true
::
8 During
:>
8 After

[Next](#)

<: 
```rb
    putz subject = args.outputs.primitives[2...5]
    expect = [{:x=>200, :y=>604, :text=>"8 Before ", :primitive_marker=>:label, :font=>"fonts/Roboto/Roboto-Regular.ttf", :size_enum=>0, :line_spacing=>1, :r=>204, :g=>204, :b=>204, :spacing_between=>0.6, :spacing_after=>0.9, :size_px=>22.0}, {:x=>274, :y=>604, :text=>"8 During ", :primitive_marker=>:label, :font=>"fonts/Roboto/Roboto-Regular.ttf", :size_enum=>0, :line_spacing=>1, :r=>204, :g=>204, :b=>204, :spacing_between=>0.6, :spacing_after=>0.9, :size_px=>22.0}, {:x=>349, :y=>604, :text=>"8 After ", :primitive_marker=>:label, :font=>"fonts/Roboto/Roboto-Regular.ttf", :size_enum=>0, :line_spacing=>1, :r=>204, :g=>204, :b=>204, :spacing_between=>0.6, :spacing_after=>0.9, :size_px=>22.0}]
    expect == subject ? "Test passed " : "Test failed"
```
:>

## Single line string interpolation

Single line string interpolation is wrapped in `<:` and `:>` symbols.

<: "This text is conditional" :>

[Next](#)

## Multi line string interpolation

Multi line string interpolation has the `<:` on the preceding line and `:>` on the following line.

<:
"This text is conditional"
:>

[Next](#)

## String Interpolation requires a string expression {#string-interpolation-string-1}

If string interpolation returns a string, it is displayed. 

Example. The following line is displayed with String Interpolation.

<: "This line is displayed with String Interpolation" :>

[Next](#)



## String Interpolation requires a string expression {#string-interpolation-string-2}

If string interpolation returns a non-string. nothing is displayed.

Example. The following line returns a number so it is not displayed.

<: 1 :>

[Next](#)

## String Interpolation within a paragraph {#string-interpolation-in-para}

Strings can be interpolated within another string using single line breaks.

Example:

This is the first part.
<: "This is the second part." :>
This is the third part.

[Next](#)


## Conditional content {#conditional-content-1}

In a conditional content container, content appears if the condition is true.

Example. The following line appears because the condition is true.

<: 
  true 
:: 
  This line appears because the condition is true. 
:>

[Next](#)

## Conditional content {#conditional-content-2}

In a conditional content container, content is hidden if the condition is false.

Example. The following line is not visible because the condition is false.

<: 
  false 
:: 
  This line is hidden because the condition is false. 
:>

This line follows the condition

[Next](#)

## Conditional content within a paragraph {#conditional-content-in-paragraph-1}

Conditional content can be inserted into an existing paragraph.

Visible Example:

This is the first part.
<:
  true
::
  "This is the second part."
:>
This is the third part.

[Next](#)

## Conditional content within a paragraph {#conditional-content-in-paragraph-2}

Invisible Example

One.
<:
false
::
Two.
:>
Three.

[Next](#)

## Conditional content within a paragraph {#conditional-content-in-paragraph-3}

Interpolation.

One part, 
<:
  "two part,"
:>
three part.

[Next](#)

## Conditional is empty except for a blank line

<:
```rb
  true
```
::

:>

[next](#)

## First line of conditional text is blank

<:
```rb
  true
```
::

insert a blank line before this one for a crash
:>

[next](#)

## Conditional with blockquote, blank line, text
<:
```rb
  true
```
::
  > TELL SWEETHEART "I LOVE YOU"

insert a blank line before this one for a crash
:>
