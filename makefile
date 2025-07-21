.PHONY: all help conda venv clean

# Default help message.
all: help

help:
	@echo "ML Assessment Environment Management"
	@echo ""
	@echo "Available targets:"
	@echo "  conda        Create a Conda environment from environment.yml"
	@echo "  clean-conda  Remove Conda env named 'llm-assessment'"
	@echo ""
	@echo "Usage:"
	@echo "  make conda        # for Conda env"
	@echo "  make clean-conda  # remove conda env"
	@echo "  make build         # build and run Docker"
	@echo "  make clean-build   # cleanup Docker containers and images"
	@echo ""
	@echo "Manual activation:"
	@echo "  conda activate llm-assessment"

conda:
	@echo "Creating or updating Conda environment 'llm-assessment'..."
	conda env create -f environment.yml || conda env update -f environment.yml
	@echo "To activate: conda activate llm-assessment"

clean-conda:
	@echo "Removing Conda environment 'llm-assessment'..."
	conda env remove -n llm-assessment -y

build:
	chmod +x shell/build-and-run.sh
	shell/build-and-run.sh

clean-build:
	chmod +x shell/clean.sh
	shell/clean.sh

nvidia-container-toolkit:
	chmod +x shell/install-nvidia-container-toolkit.sh
	shell/install-nvidia-container-toolkit.sh