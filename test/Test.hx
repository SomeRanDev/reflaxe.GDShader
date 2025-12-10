package;

import fecal.data.GenerateBuildCommandData;
import fecal.data.GenerateExecuteCommandData;
import fecal.data.GenerateTestArgumentsData;
import fecal.Fecal;

function main() {
	switch(Fecal.test(
		"unit_tests",
		null,
		function(data: GenerateTestArgumentsData): Array<String> {
			return [
				"--no-opt",
				"-cp ../src",
				"-cp ../std",
				"-cp ../std/gdshader/_std",
				"-cp ../api",
				"-lib reflaxe",
				"../extraParams.hxml",
				"-cp " + data.testDirectory,
				"-D message-reporting=pretty",
				"-D reflaxe.dont_output_metadata_id",
				"--custom-target gdshader=" + data.outputDirectory,
				"\"" + data.hxmlFile.absolutePath + "\""
			];
		},
		null,
		null,
	)) {
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
