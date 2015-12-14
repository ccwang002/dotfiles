function init -a path --on-event init_virtualfish
    source $path/functions/virtual.load
    source $path/functions/auto_activation.load
    source $path/functions/global_requirements.load
end
