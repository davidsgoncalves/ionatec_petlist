'use strict';

import _     from 'lodash';
import React from 'react';
import { Pagination } from 'react-bootstrap';

export default function PaginationComponent({ label, page, pageSize, total, onSelect }) {
    if (!total || total <= pageSize)
        return null;

    const items = Math.ceil(total / pageSize);

    return (
        <section>
            <Entries label={label} page={page} pageSize={pageSize} total={total}/>
            <Pagination className="pull-right" activePage={page} onSelect={(e) => onSelect({ page: e })}
                        items={items} prev next first last ellipsis maxButtons={5}/>
        </section>
    );
}
PaginationComponent.propTypes = {
    label: React.PropTypes.string.isRequired,
    page: React.PropTypes.number,
    pageSize: React.PropTypes.number,
    total: React.PropTypes.number,
    onSelect: React.PropTypes.func
};
PaginationComponent.defaultProps = { page: 1, pageSize: 20, onSelect: _.noop };

export function Entries({ label, page, pageSize, total }) {
    if (!total || total <= pageSize)
        return null;

    const first = ((page - 1) * pageSize) + 1,
        last  = Math.min(total, page * pageSize);

    return (
        <section>
            Exibindo {label}, <b>{first}&nbsp;-&nbsp;{last}</b> de <b>{total}</b>.
        </section>
    );
}
Entries.propTypes = {
    label: React.PropTypes.string.isRequired,
    page: React.PropTypes.number,
    pageSize: React.PropTypes.number,
    total: React.PropTypes.number,
};
Entries.defaultProps = { page: 1, pageSize: 20 };