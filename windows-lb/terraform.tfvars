# NOTE - tenancy_id is not defined here.  it is defined in each environment file.
# This is specifically done since there are variables tied to the actual tenancy in the environment files.
# If you need to update a stack, this file must be for a user in the tenancy listed in the environment file.

### Authentication details
tenancy_ocid =  "ocid1.tenancy.oc1..aaaaaaaawgbzspd6cjovpmic7dahwbalg4opcbixgguo6z2s7t335m6lalbq" #"ocid1.tenancy.oc1..aaaaaaaagkbzgg6lpzrf47xzy4rjoxg4de6ncfiq2rncmjiujvy2hjgxvziq"
user_ocid = "ocid1.user.oc1..aaaaaaaakbm65mctre4i4wom6sam6z4amtjc5vin3iqsa4z3bzpdvoaieioq" #"ocid1.user.oc1..aaaaaaaaju4h4lir5jpigeze4u5u53s2sz3qye3xcrgr7mczvbgzprmzme3q"
fingerprint = "1e:d7:31:b6:d9:bc:5f:11:2d:ec:03:45:b0:5f:58:69"
private_key_path = "/Users/vchandak/.oci/oci_api_key.pem"

### Region
region = "us-phoenix-1"

### Compartment
compartment_ocid = "ocid1.compartment.oc1..aaaaaaaagxh5kocy6g6of5znwe35ckxn6ddkdqwoif7qjcx3igm2fareke2q" #"ocid1.compartment.oc1..aaaaaaaahfbspptezfjw34xm2kxpyo3i6qcc6zhlyguglt3idwmsqnqd5ddq"