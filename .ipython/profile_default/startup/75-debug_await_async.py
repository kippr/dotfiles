import builtins
def _await(task_or_coro):
    """Support for running async functions in ipdb: `_await(my_async_function())`"""
    import asyncio
    from asyncio import tasks
    task = asyncio.ensure_future(task_or_coro)
    loop, current_task = task.get_loop(), tasks.current_task()
    tasks._leave_task(loop, current_task)
    while not task.done():
        loop._run_once()
    tasks._enter_task(loop, current_task)
    return task.result()
builtins._await = _await
print(f'Loaded _await into builtins')
