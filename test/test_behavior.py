import logging
import os
from pathlib import Path

import behavior.datagen.gen
import behavior.modeling.train
import behavior.plans.diff

logger = logging.getLogger(__name__)
logging.basicConfig(format="%(levelname)s:%(asctime)s %(message)s", level=logging.DEBUG)


def test_behavior_datagen():
    init_dir = Path.cwd()
    pilot_dir = Path.home() / "noisepage-pilot"

    if init_dir != pilot_dir:
        os.chdir(pilot_dir)

    data_dir = Path("./artifacts/behavior/datagen/training_data")
    train_folder = data_dir / "train"
    output_dir = Path("./artifacts/behavior/datagen/differenced_data")
    experiments = sorted(path.name for path in train_folder.glob("*"))
    assert len(experiments) > 0, "No training data found?"
    latest_experiment = experiments[-1]

    behavior.datagen.gen.main(data_dir, output_dir, latest_experiment)

    if Path.cwd() != init_dir:
        os.chdir(init_dir)


def test_behavior_datadiff():
    init_dir = Path.cwd()
    pilot_dir = Path.home() / "noisepage-pilot"

    if init_dir != pilot_dir:
        os.chdir(pilot_dir)

    data_dir = Path("./artifacts/behavior/datagen/training_data")
    train_folder = data_dir / "train"
    output_dir = Path("./artifacts/behavior/datagen/differenced_data")
    experiments = sorted(path.name for path in train_folder.glob("*"))
    assert len(experiments) > 0, "No training data found?"
    latest_experiment = experiments[-1]

    behavior.plans.diff.main(data_dir, output_dir, latest_experiment)

    if Path.cwd() != init_dir:
        os.chdir(init_dir)
