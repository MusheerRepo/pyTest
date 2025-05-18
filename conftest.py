def pytest_addoption(parser):
    parser.addoption(
        "--allure-dir",
        action="store",
        default="allure-results",
        help="Directory to store Allure results"
    )

#changes