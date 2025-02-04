def __set_defaults_asteroidos_yocto():
	set_default('DISTRO', 'asteroid')

def __after_init_asteroidos_yocto():
	PLATFORM_ROOT_DIR = os.environ['PLATFORM_ROOT_DIR']

	append_layers([ os.path.join(PLATFORM_ROOT_DIR, 'sources', p) for p in
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
			'meta-smartwatch/meta-dory',
		]
	])

run_set_defaults(__set_defaults_asteroidos_yocto)
run_after_init(__after_init_asteroidos_yocto)
