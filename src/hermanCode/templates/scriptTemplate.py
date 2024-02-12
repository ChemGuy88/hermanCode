"""
This is a python script template from Herman's Code.
"""

import logging
from pathlib import Path
#
# Local packages
from drapi.code.drapi.drapi import (getTimestamp,
                                    makeDirPath,
                                    successiveParents)

# Arguments
SLEEP_BOUND_LOWER = 1
SLEEP_BOUND_UPPER = 10
WEBDRIVERWAIT_TIMEOUT_LIMIT = 20
TEST_MODE = True

# Arguments: Meta-variables
PROJECT_DIR_DEPTH = 2
USER_HOME_DIRECTORY_DEPTH = PROJECT_DIR_DEPTH + 3
ROOT_DIRECTORY_DEPTH = PROJECT_DIR_DEPTH + 5

ROOT_DIRECTORY = "PROJECT_OR_PORTION_DIRECTORY"  # TODO One of the following:
                                                 # ["PROJECT_OR_PORTION_DIRECTORY",  # noqa
                                                 #  "USER_HOME_DIRECTORY",           # noqa
                                                 #  "ROOT_DIRECTORY"]                # noqa

LOG_LEVEL = "INFO"

# Variables: Path construction: General
runTimestamp = getTimestamp()
thisFilePath = Path(__file__)
thisFileStem = thisFilePath.stem
projectDir, _ = successiveParents(thisFilePath.absolute(), PROJECT_DIR_DEPTH)
userHomeDir, _ = successiveParents(thisFilePath.absolute(), USER_HOME_DIRECTORY_DEPTH)
rootDir, _ = successiveParents(thisFilePath.absolute(), ROOT_DIRECTORY_DEPTH)
dataDir = projectDir.joinpath("data")
if dataDir:
    inputDataDir = dataDir.joinpath("input")
    outputDataDir = dataDir.joinpath("output")
    if outputDataDir:
        runOutputDir = outputDataDir.joinpath(thisFileStem, runTimestamp)
logsDir = projectDir.joinpath("logs")
if logsDir:
    runLogsDir = logsDir.joinpath(thisFileStem)
sqlDir = projectDir.joinpath("sql")

if ROOT_DIRECTORY == "PROJECT_OR_PORTION_DIRECTORY":
    rootDirectory = projectDir
elif ROOT_DIRECTORY == "USER_HOME_DIRECTORY":
    rootDirectory = userHomeDir
elif ROOT_DIRECTORY == "ROOT_DIRECTORY":
    rootDirectory = rootDir
else:
    raise Exception("An unexpected error occurred.")

# Variables: Other
pass

# Directory creation: General
makeDirPath(runOutputDir)
makeDirPath(runLogsDir)

# Functions
pass

# Logging block
logpath = runLogsDir.joinpath(f"log {runTimestamp}.log")
logFormat = logging.Formatter("""[%(asctime)s][%(levelname)s](%(funcName)s): %(message)s""")

logger = logging.getLogger(__name__)

fileHandler = logging.FileHandler(logpath)
fileHandler.setLevel(9)
fileHandler.setFormatter(logFormat)

streamHandler = logging.StreamHandler()
streamHandler.setLevel(LOG_LEVEL)
streamHandler.setFormatter(logFormat)

logger.addHandler(fileHandler)
logger.addHandler(streamHandler)

logger.setLevel(9)

if __name__ == "__main__":
    logger.info(f"""Begin running "{thisFilePath}".""")
    logger.info(f"""All other paths will be reported in debugging relative to `{ROOT_DIRECTORY}`: "{rootDirectory}".""")
    logger.info(f"""Script arguments:


    # Arguments
    ``: "{""}"

    # Arguments: General
    `PROJECT_DIR_DEPTH`: "{PROJECT_DIR_DEPTH}" ---------> "{projectDir}"
    `USER_HOME_DIRECTORY_DEPTH`: "{USER_HOME_DIRECTORY_DEPTH}" -> "{userHomeDir}"
    `ROOT_DIRECTORY_DEPTH`: "{ROOT_DIRECTORY_DEPTH}" ------> "{rootDir}"

    `LOG_LEVEL` = "{LOG_LEVEL}"
    """)

    # Script
    pass

    # End script
    logger.info(f"""Finished running "{thisFilePath.absolute().relative_to(rootDirectory)}".""")
