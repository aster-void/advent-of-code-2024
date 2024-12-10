import { step1, step2 } from "./lib";

const input = await Bun.file("./input.txt").text();

const step = Bun.argv[2];
switch (step) {
	case "1":
		console.log(step1(input));
		break;
	case "2":
		console.log(step2(input));
		break;
	default:
		console.error(`Unexpected command argument. expected 1 or 2, got ${step}`);
}
