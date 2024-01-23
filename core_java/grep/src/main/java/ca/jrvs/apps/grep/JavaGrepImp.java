package ca.jrvs.apps.grep;

import com.sun.org.apache.xerces.internal.parsers.BasicParserConfiguration;
import org.apache.log4j.BasicConfigurator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.lang.Object;
import java.util.*;
import java.util.regex.Pattern;


public class JavaGrepImp implements JavaGrep {

    final Logger logger = LoggerFactory.getLogger(JavaGrep.class);

    private String regex;
    private String rootPath;
    private String outFile;

    @Override
    public String getRegex() {
        return regex;
    }

    @Override
    public void setRegex(String regex) {
        this.regex = regex;
    }

    @Override
    public String getRootPath() {
        return rootPath;
    }

    @Override
    public void setRootPath(String rootPath) {
        this.rootPath = rootPath;
    }

    @Override
    public String getOutFile() {
        return outFile;
    }

    @Override
    public void setOutFile(String outFile) {
        this.outFile = outFile;
    }

    @Override
    public void process() throws IOException {
        List<String> matchedLines = new ArrayList<String>();
        List<File> listofFiles = listFiles(getRootPath());
        for(File file1 : listofFiles){
            List<String> fileLines = readLines(file1);
            for(String line1 : fileLines){
                if(containsPatterm(line1)){
                    matchedLines.add(line1);
                }
            }
        }
        writeToFile(matchedLines);
    }
    List<File> listOfFiles = new ArrayList<File>();
    @Override
    public List<File> listFiles(String rootDir) {
        File directory = new File(rootDir);

        for(File file1 : directory.listFiles()){
            if(file1.isDirectory()) {
                listFiles(file1.toString());
            }
            else if(file1.isFile()) {
                listOfFiles.add(file1);
            }
        }
        return listOfFiles;
    }

    @Override
    public List<String> readLines(File inputFile) {

        List<String> linesList = new ArrayList<String>();
        try {
            BufferedReader reader = new BufferedReader(new FileReader((inputFile)));
            String line = reader.readLine();
            while(line != null){
                linesList.add(line);
                line = reader.readLine();
            }
        }
        catch (IOException e){
            System.out.println(e.toString());
        }

        return linesList;
    }

    @Override
    public boolean containsPatterm(String line) {
        return Pattern.matches(getRegex(), line);
    }

    @Override
    public void writeToFile(List<String> lines) throws IOException {
            File outputFile = new File(getOutFile());
            outputFile.createNewFile();
            FileWriter writer = new FileWriter(outputFile);
            for (String line : lines) {
                writer.write(line);
            }

            writer.close();
    }

    public static void main(String[] args) {
        if(args.length != 3){
            throw new IllegalArgumentException("USAGE: JavaGrep regex rootPath outFile");

        }

        BasicConfigurator.configure();

        JavaGrepImp javaGrepImp = new JavaGrepImp();
        javaGrepImp.setRegex(args[0]);
        javaGrepImp.setRootPath(args[1]);
        javaGrepImp.setOutFile(args[2]);

        try {
            javaGrepImp.process();
        } catch (Exception ex){
            javaGrepImp.logger.error("Error: Unable to process", ex);
        }
    }
}
