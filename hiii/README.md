# HIII: an HTML text-replacement thing

input file
```
<!-- !MyReplacementThing arg1 arg2 -->
	<p>the first thing is @arg1</p>
	<p>also @arg2</p>
<!-- . -->

<blockquote>
	<!-- $MyReplacementThing input1 «input2 with whitespace     inside of it» -->
</blockquote>
```

produces outputs
```
<blockquote>
        <p>the first thing is input1</p>
        <p>also input2 with whitespace     inside of it</p>
</blockquote>
```
(with a bunch of random newlines)

notes:
- replacementthings inside of other replacementthings will be evaluated
- you can't escape «»s as of now so there's basically no way to use them as inputs
- usage: `./hi.rb <input file name>` (stdin would actually prob be better since it outputs to stdout :thinking:)
