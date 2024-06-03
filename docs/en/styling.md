# Styling

## General styling

+ Please use a tab character to indent thus the code reader can decide how wide an indent can be. But for Dart, considering it's number of indents a line may have, please use two space characters instead.

+ When typing controlling sentences like `if`, `while`, or class/enum definition blocks, use K&R style. But when typing a function, you may use an independent line to contain `{` instead. It's especially helpful when writing a Rust function (but following K&R is also okay).

+ Avoid placing multiple sentences into one line.

## Line breaking

+ A line contains 80 characters at most. When it comes to more than 80 characters, consider break it into multiple lines.

+ When a function has too many parameters, place them one for each line.

```cpp
void yourfunction(
	int para1,
	char *para2,
	YourStructA para3,
	Vector<YourStructB> para4,
	void *para5
){
	// The function body.
}
```

+ Same for calling a function.

```cpp
memcpy(
	a_string_destination,
	a_string_source,
	number
);
```

+ When breaking an expression, insert an indent before the second and following lines to discriminate them from the first line. place the operator at the beginning of each line rather than a variable symbol.

```python
print(
	"The expression you typed is " + number_A + '+' + number_B + '+' number_C
		+ '=' + (number_A + number_B + numberC) + '.\n'
)
```

+ When writing docs, break lines for `txt` format files and not for Markdown files. It'll be strange to read for Markdown programs sometimes as they break the lines automatically, but a TXT reader usually does not break the lines.

## Rust styling

+ Follow Rust's naming requirements, `snake_case` for local variables for example.

+ Use an indent for each mods, functions and structs.

```rust
fn a_function_with_a_return_value_whose_type_is_long(para1: String)
	-> Result(Vec<(YourClassA, YourClassB)>, YourCustomError)
{
	// The function body.
}
```

## Dart styling

+ Follow Dart's naming requirements, `lowCamelCase` for local variables for example.