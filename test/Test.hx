package;

import fecal.Fecal;
import fecal.FecalTest;

class GDShaderTest extends FecalTest {
	public override function generateHaxeCompilationArguments(
		outputDirectory: String,
		testDirectory: String,
		hxmlFile: { name: String, absolutePath: String },
		arguments: fecal.data.Arguments,
	): Array<String> {
		return [
			"--no-opt",
			"-cp ../src",
			"-cp ../std",
			"-cp ../std/gdshader/_std",
			"-cp ../api",
			"-lib reflaxe",
			"../extraParams.hxml",
			"-cp " + testDirectory,
			"-D message-reporting=pretty",
			"-D reflaxe.dont_output_metadata_id",
			"--custom-target gdshader=" + outputDirectory,
			"\"" + hxmlFile.absolutePath + "\""
		];
	}
}

function main() {
	final test = new GDShaderTest(
		"unit_tests",
		null,
	);

	final result = Fecal.test(test);

	switch(result) {
		case Ok(PassedTests(testCount)): {
			Sys.println('$testCount / $testCount tests passed!');
		}
		case Ok(FailedComparisonTests(failureCount, testCount)): {
			Sys.println('$failureCount / $testCount tests failed.');
			Sys.exit(1);
		}
		case Ok(FailedBuildOrExecuteTests(failures, testCount)): {
			Sys.println("The following failed: " + failures);
			Sys.exit(1);
		}
		case Ok(PrintedHelp): {}
		case Ok(NeverBuild): {}
		case DirectoryCouldNotBeFound(path): {
			Sys.println('$path does not exist.');
			Sys.exit(1);
		}
		case UnsupportedPlatform(platform): {
			Sys.println('GDShader compilation test not supported for `$platform`');
			Sys.exit(1);
		}
		case SpecifiedTestsDoNotExist(tests): {
			Sys.println('The provided tests do not exist: $tests');
			Sys.exit(1);
		}
		case BuildFailed(output): {
			Sys.println("GDShader build failed.");

			Sys.println("--- Build Output ---");
			Sys.println(output.stdout());
			Sys.println(output.stderr());
		}
		case ExecutionFailed(buildOutput, executionOutput, exitCode): {
			Sys.println("--- Build Output ---");
			Sys.println(buildOutput.stdout());
			Sys.println(buildOutput.stderr());

			Sys.println('Executable returned exit code: $exitCode');
			Sys.println("--- Execution Output ---");
			Sys.println(executionOutput.stdout());
			Sys.println(executionOutput.stderr());
		}
	}
}
