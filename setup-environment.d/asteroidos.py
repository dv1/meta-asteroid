def __set_defaults_asteroidos_yocto():
	set_default('DISTRO', 'asteroid')

def __after_init_asteroidos_yocto():
	platform_root_dir = os.environ['PLATFORM_ROOT_DIR']

	# Prefer the MACHINE from the environment as the smartwatch to use.
	# When setup-environment is run for the first time, it is normal
	# that that env variable is set. When it was previously already run
	# though, and conf/local.conf already exists, often, the MACHINE
	# env variable is _not_ set. In that case, resort to reading its
	# value from LOCAL_CONF (which contains the conf/local.conf content).
	smartwatch = None
	try:
		smartwatch = os.environ['MACHINE']
	except KeyError:
		for assignment in LOCAL_CONF.conf_data:
			if assignment[0] == 'MACHINE':
				try:
					smartwatch = assignment[2][0]
				except IndexError:
					pass
				except TypeError:
					pass

	if smartwatch == None:
		sys.stderr.write('ERROR: Could not determine smartwatch to build for.')
		sys.exit(1)

	sys.stderr.write('Will build for smartwatch "{}"\n'.format(smartwatch))

	append_layers([ os.path.join(platform_root_dir, 'sources', p) for p in
		[
			'meta-openembedded/meta-oe',
			'meta-openembedded/meta-multimedia',
			'meta-openembedded/meta-gnome',
			'meta-openembedded/meta-networking',
			'meta-openembedded/meta-filesystems',
			'meta-openembedded/meta-python',
			'meta-smartphone/meta-android',
			'meta-qt5',
			'meta-asteroid',
			'meta-asteroid-community',
			'meta-smartwatch/meta-' + smartwatch,
		]
	])

run_set_defaults(__set_defaults_asteroidos_yocto)
run_after_init(__after_init_asteroidos_yocto)
