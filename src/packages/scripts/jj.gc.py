# /// script
# dependencies = [
# 	"arrow~=1.3",
# ]
# ///
from typing import Optional, Tuple
import sys
import arrow
import subprocess

DEFAULT_TIME_ARG = 14

def get_op_id() -> Optional[Tuple[str, str]]:
	try:
		jj_op_log_results = subprocess.run(
			args=[
				"jj",
				"op",
				"log",
				"--no-graph",
				"--no-pager",
				"-T", 'self.id() ++ "|" ++ self.time().end() ++ "\n"',
			],
			capture_output=True,
			text=True,
			check=True
		)

		if len(sys.argv) > 1:
			time_arg = int(sys.argv[1])
		else:
			time_arg = DEFAULT_TIME_ARG

		target_time = arrow.now().shift(days=(-time_arg))
		print(f"Finding time earlier than: {target_time}")
		root_op_id = '0' * 128

		for line in jj_op_log_results.stdout.splitlines():
			separated = line.split("|")
			op_id = separated[0]
			timestamp = separated[1]
			parsed_timestamp = arrow.get(timestamp, 'YYYY-MM-DD HH:mm:ss.SSS ZZ')
			if parsed_timestamp < target_time:
				if op_id != root_op_id:
					return op_id, timestamp
				else:
					return None

	except Exception as e:
		print("An Error occurred")
		print(e)
		sys.exit(1)

def abandon_ops(op_id: str):
	subprocess.run(
			args=[
				"jj",
				"op",
				"abandon",
				f"..{op_id}"
			],
			capture_output=False,
			check=True
		)

	print("Operations pruned, cleaning up git repo.")

	subprocess.run(
			args=[
				"jj",
				"util",
				"gc",
			],
			capture_output=False,
			check=True
		)

target_op_id_res = get_op_id()
if target_op_id_res is None:
	print("Root op found, skipping")
	sys.exit(0)

target_op_id, timestamp = target_op_id_res
print(f"Found op: {target_op_id}")
print(f"Timestamp: {timestamp}")
should_continue = input("Continue? (y/n) ").strip().lower()

if should_continue == "y" or should_continue == "yes":
	abandon_ops(target_op_id)
	print("Finished.")
else:
	print("Not Proceeding.")
