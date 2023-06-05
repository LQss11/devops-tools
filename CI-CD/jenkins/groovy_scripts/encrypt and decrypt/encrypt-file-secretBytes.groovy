import com.cloudbees.plugins.credentials.*
import java.nio.file.*

String filePath = '/root/.ssh/id_rsa'
Path fileLocation = Paths.get(filePath)
def secretBytes = SecretBytes.fromBytes(Files.readAllBytes(fileLocation))