const reg1 = /mul\(\d+,\d+\)/g;
export function step1(input: string): number | null {
	return (
		input
			.match(reg1)
			?.map((match) => {
				const [a, b] = match.slice(4).replaceAll(")", "").split(",");
				return Number.parseInt(a) * Number.parseInt(b);
			})
			.filter((v) => v !== null)
			.reduce((a, b) => a + b, 0) ?? null
	);
}

const reg2 = /mul\(\d+,\d+\)|don't\(\)|do\(\)/g;
export function step2(input: string): number | null {
	let should = true;
	return (
		input
			.match(reg2)
			?.map((match) => {
				if (match === "don't()") {
					should = false;
					return null;
				}
				if (match === "do()") {
					should = true;
					return null;
				}
				const [a, b] = match.slice(4).replaceAll(")", "").split(",");
				return should ? Number.parseInt(a) * Number.parseInt(b) : null;
			})
			.filter((v) => v !== null)
			.reduce((a, b) => a + b, 0) ?? null
	);
}
