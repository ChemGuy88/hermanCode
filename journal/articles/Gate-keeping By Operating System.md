# Gate-keeping By Operating System

Here's a template for funneling process according to the operating system.

## BASH

```bash
if [[ $OSTYPE == "darwin"* ]]; then
    # macOS
    :
elif [[ $OSTYPE == "linux-gnu"* ]]; then
    # Linux
    :
else
    echo "Unsupported operating system."
    exit 1
fi
```
