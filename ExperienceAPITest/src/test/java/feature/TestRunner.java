package feature;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;

import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import com.intuit.karate.junit5.Karate;

import static org.junit.jupiter.api.Assertions.*;

public class TestRunner 
{
	@Test
	public void testParallel() {
        Results results = Runner.path("classpath:feature").parallel(5);
        assertTrue(results.getFailCount()==0, results.getErrorMessages());
        generateReport(results.getReportDir());
    }
	
	public void generateReport(String karateOutputPath){
		Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
		final List<String> jsonPaths = new ArrayList(jsonFiles.size());
		jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
		Configuration config = new Configuration(new File("target"),"CCAI_Automation");
		ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
		reportBuilder.generateReports();
	}
	
//	@Karate.Test
//	Karate testSample() {
//		return Karate.run("classpath:feature/testAPI.feature").relativeTo(getClass());
//	}
}
