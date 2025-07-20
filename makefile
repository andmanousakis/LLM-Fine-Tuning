.PHONY: all help conda venv clean

# Default help message.
all: help

help:
	@echo "ML Assessment Environment Management"
	@echo ""
	@echo "Available targets:"
	@echo "  conda        Create a Conda environment from environment.yml"
	@echo "  venv         Create a Python venv and install requirements.txt"
	@echo "  clean-venv   Remove venv folder"
	@echo "  clean-conda  Remove Conda env named 'llm-assessment'"
	@echo ""
	@echo "Usage:"
	@echo "  make conda        # for Conda env"
	@echo "  make venv         # for venv + pip"
	@echo "  make clean-venv   # remove venv"
	@echo "  make clean-conda  # remove conda env"
	@echo ""
	@echo "Manual activation:"
	@echo "  conda activate llm-assessment"
	@echo "  source venv/bin/activate"

conda:
	@echo "Creating or updating Conda environment 'llm-assessment'..."
	conda env create -f environment.yml || conda env update -f environment.yml
	@echo "To activate: conda activate llm-assessment"

clean-conda:
	@echo "Removing Conda environment 'llm-assessment'..."
	conda env remove -n llm-assessment -y