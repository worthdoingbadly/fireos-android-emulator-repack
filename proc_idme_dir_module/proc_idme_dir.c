/* https://unix.stackexchange.com/a/656871 */
#include <linux/module.h>
#include <linux/proc_fs.h>

static int proc_idme_dir_init(void) {
    proc_mkdir("idme", NULL);
    return 0;
}

module_init(proc_idme_dir_init);
MODULE_LICENSE("GPL");
