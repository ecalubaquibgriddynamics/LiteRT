""" Macros for manylinux compliance verification test. """

load("@org_tensorflow//tensorflow:strict.default.bzl", "py_strict_test")

def verify_manylinux_compliance_test(
        name,
        wheel,
        aarch64_compliance_tag,
        x86_64_compliance_tag,
        ppc64le_compliance_tag,
        test_tags = []):
    py_strict_test(
        name = name,
        srcs = [Label("//tflite/tools/pip_package/utils:manylinux_compliance_test")],
        data = [
            wheel,
        ],
        deps = ["@pypi_auditwheel//:pkg"],
        args = [
            "--wheel-path=$(location {})".format(wheel),
            "--aarch64-compliance-tag={}".format(aarch64_compliance_tag),
            "--x86_64-compliance-tag={}".format(x86_64_compliance_tag),
            "--ppc64le-compliance-tag={}".format(ppc64le_compliance_tag),
        ],
        main = "manylinux_compliance_test.py",
        tags = ["manual"] + test_tags,
    )
