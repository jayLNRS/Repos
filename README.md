# performance-load-testing
Performance & Load Testing Resources
## 
## Usage

- JMX file has to upload to "jmx" directory.
- GH Actions workflow name: __JMeter Performance test__

To perform a test you need to provide the following information in Run workflow option in GitHub Action.
1. ENV must be __PP__
2. DB cleanup must be selected as __False__
3. jmx file name (without jmx extension)
4. Journey ID (optional)
5. number of loops needed
6. name prefix of the environment must be __lon-pp__
7. Test organisation ID
8. Number of requests needed
9. Strategy ID

Once the testing is completed, you may need to delete the data in the test organization. To do this 
- Rerun GH Actions workflow name: __JMeter Performance test__

Makesure you select DB cleanup to __True__
