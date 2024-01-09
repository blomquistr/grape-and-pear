import os

from flask import Flask

app = Flask(__name__)


@app.route("/")
def ping():
    return ("pong", 200)


@app.route("/grape")
def grape():
    return ("grape", 200)


@app.route("/pear")
def pear():
    return ("pear", 200)


def main() -> None:
    import argparse

    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--host",
        type=str,
        default=os.environ.get(
            "GRAPE_AND_PEAR_HOST",
            "0.0.0.0",
        ),
    )
    parser.add_argument(
        "--port",
        type=int,
        default=int(
            os.environ.get(
                "GRAPE_AND_PEAR_PORT",
                5001,
            )
        ),
    )
    parser.add_argument("--debug", action="store_true")

    args = parser.parse_args()
    app.run(host=args.host, port=args.port, debug=args.debug)


if __name__ == "__main__":
    main()
