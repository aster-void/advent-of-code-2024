import { expect, test } from "bun:test";
import { step1, step2 } from "../src/lib";

test("test", () => {
	const input =
		"xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))";
	expect(step1(input)).toBe(161);
});

test("step2", () => {
	const input =
		"xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))";
	expect(step2(input)).toBe(48);
});
